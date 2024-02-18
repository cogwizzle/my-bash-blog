# Testing React
I have been developing in React for years. Since the transition to hooks I've noticed that React has gotten... messy. I am sure if you have been working with React for any amount of time you have seen this too. Functional components that are 1000 lines long. Test that are 99% mocks and windy logic that is impossible to follow. So what is a developer to do in this situation?

All of these problems are related. Your components are too big. Your tests are too complex. I intend to address that problem in this post.

## Example
Let's start with a simple example. Form components are great for this conversation. They are simple, but the React code required to wire one up is complex.

Here we have a relatively simple form that depends on an imaginary external data source. You can look at this and think, hey this isn't so bad but there is a lot of hidden complexity here.

my-form-component.js
```jsx
import React, { useState, useEffect } from 'react'
import { gql, useQuery } from '@apollo/client'
import { toast } from 'react-toastify'

const GetCountries = gql`
    query GetCountries {
        countries {
            id
            name
        }
    }
`

const MyForm = (props) => {
    const [name, setName] = useState('')
    const [phone, setPhone] = useState('')
    const [email, setEmail] = useState('')
    const [country, setCountry] = useState('')
    const { data, loading, error } = useQuery(GetCountries)
    const countries = data?.countries || []
    const onSubmit = (e) => {
        e.preventDefault()
        props.onSubmit({name, phone, email})
    }
    useEffect(() => {
        if (error) {
            toast.error(error)
        }
    }, [error])
    
    return (
        <form onSubmit={onSubmit}>
            <label htmlFor="name">Name</label>
            <input type="text" id="name" value={name} onChange={e => setName(e.target.value)} />
            <label htmlFor="phone">Phone</label>
            <input type="text" id="phone" value={phone} onChange={e => setPhone(e.target.value)} />
            <label htmlFor="email">Email</label>
            <input type="text" id="email" value={email} onChange={e => setEmail(e.target.value)} />
            <label htmlFor="country">Country</label>
            {loading
                ? null
                : (
                    <select id="country" onChange={e => setCountry(e.target.value)}>
                        {countries.map(country => <option key={country.id} value={country.id}>{country.name}</option>)}
                    </select>
                )
            }
            <submit>Submit</submit> 
        </form>
    )
}
```

For starters, there is a query that is being made to an external data source. This would become hard to write a test for. Additionally, there is a component that conditionally renders based on the loading state. There is also an effect hook that only is triggered when an Apollo error exists. This component is small too. This is not the 1000-line monolithic component, but there is a lot of complexity.

So to keep things simple let's break this component down into smaller pieces. Then we'll write the test easily.

## Breaking it down
The first thing we can do is break the business logic out of the component. We can do this by building a custom hook specific to contain this logic.

use-my-form-component.js
```jsx
import { useState, useEffect } from 'react'
import { gql, useQuery } from '@apollo/client'
import { toast } from 'react-toastify'

const GetCountries = gql`
    query GetCountries {
        countries {
            id
            name
        }
    }
`

export default function useMyFormComponent({ onSubmit }) {
    const [name, setName] = useState('')
    const [phone, setPhone] = useState('')
    const [email, setEmail] = useState('')
    const { data, loading, error } = useQuery(GetCountries)
    const countries = data?.countries || []
    const onSubmit = (e) => {
        e.preventDefault()
        props.onSubmit({name, phone, email})
    }
    const onNameChange = (e) => {
        setName(e.target.value)
    }
    const onPhoneChange = (e) => {
        setPhone(e.target.value)
    }
    const onEmailChange = (e) => {
        setEmail(e.target.value)
    }
    useEffect(() => {
        if (error) {
            toast.error(error)
        }
    }, [error])
    
    return {
        countries,
        email,
        loading,
        name,
        onEmailChange,
        onNameChange,
        onPhoneChange,
        onSubmit
        phone,
    }
}
```

Let's replace the original component code with the custom hook.

my-form.js
```jsx
import React from 'react'
import useMyFormComponent from './hooks/use-my-form-component'


const MyForm = (props) => {
    const {
        countries,
        email,
        loading,
        name,
        onEmailChange,
        onNameChange,
        onPhoneChange,
        onSubmit
        phone,
    } = useMyFormComponent(props)
    
    return (
        <form onSubmit={onSubmit}>
            <label htmlFor="name">Name</label>
            <input type="text" id="name" value={name} onChange={onNameChange} />
            <label htmlFor="phone">Phone</label>
            <input type="text" id="phone" value={phone} onChange={onPhoneChange} />
            <label htmlFor="email">Email</label>
            <input type="text" id="email" value={email} onChange={onEmailChange} />
            <label htmlFor="country">Country</label>
            {loading
                ? null
                : (
                    <select id="country" onChange={onCountryChange}>
                        {countries.map(country => <option key={country.id} value={country.id}>{country.name}</option>)}
                    </select>
                )
            }
            <submit>Submit</submit> 
        </form>
    )
}
```

This is a good start, but we can make it better.

### Breaking it down further
The next thing we can do is break another custom hook out of the custom hook we just wrote. You'll notice the query hook is a good candidate to be broken down further.

use-get-countries.js
```jsx
import { gql, useQuery } from '@apollo/client'

const GetCountries = gql`
    query GetCountries {
        countries {
            id
            name
        }
    }
`

export default function useGetCountries() {
    return useQuery(GetCountries)
}
```

use-my-form-component.js
```jsx
import { useState, useEffect } from 'react'
import { toast } from 'react-toastify'
import useGetCountries from './use-get-countries'

export default function useMyFormComponent({ onSubmit }) {
    const [name, setName] = useState('')
    const [phone, setPhone] = useState('')
    const [email, setEmail] = useState('')
    const { data, loading, error } = useGetCountries()
    const countries = data?.countries || []
    const onSubmit = (e) => {
        e.preventDefault()
        props.onSubmit({name, phone, email})
    }
    useEffect(() => {
        if (error) {
            toast.error(error)
        }
    }, [error])
    
    return {
        countries,
        email,
        loading,
        name,
        onSubmit
        phone,
        setEmail,
        setName,
        setPhone,
    }
}

```

There are certainly other ways to break this down smaller too, but we'll avoid that for now. This is a good start. Let's write some tests.

## Testing
Let's test the custom hooks first. Now that these are both small functions this should be easy.

use-get-countries.test.js
```jsx
import { renderHook } from '@testing-library/react-hooks'
import { useQuery } from '@apollo/client'
import useGetCountries from './use-get-countries'

jest.mock('@apollo/client', () => ({
    __esModule: true,
    ...jest.requireAction('@apollo/client'),
    useQuery: jest.fn(),
}))

test('useGetCountries should return data, loading, and error', () => {
    jest.mocked(useQuery).mockReturnValue({
        data: { countries: [{ id: 1, name: 'USA' }] },
        loading: false,
        error: null,
    })
    const { result } = renderHook(() => useGetCountries())
    expect(result.current.data).toBeDefined()
    expect(result.current.loading).toBeFalse()
    expect(result.current.error).toBeNull()
})
```
This test is incredibly short but it ensures that our contract is being met. We can now build a manual mock of the useGetCountries hook so that we can use it elsewhere since it is being tested.

\_\_mocks\_\_/use-get-countries.js
```jsx
export default function useGetCountries() {
    return {
        data: { countries: [{ id: 1, name: 'USA' }] },
        loading: false,
        error: null,
    }
}
```

This manual mock allows us to mock this hook in other tests. This is a great way to isolate the tests.

use-my-form-component.test.js
```jsx
import { renderHook } from '@testing-library/react-hooks'
import useMyFormComponent from './use-my-form-component'
import useGetCountries from './use-get-countries'

// Automatically uses the manual mock from earlier.
jest.mock('./use-get-countries')

describe('useMyFormComponent', () => {
    test('should return countries, email, loading, name, onSubmit, phone, setEmail, setName, and setPhone.', () => {
        const onSubmit = jest.fn()
        const { result } = renderHook(() => useMyFormComponent({ onSubmit }))
        expect(result.current.countries).toBeDefined()
        expect(result.current.email).toBe('')
        expect(result.current.loading).toBeTrue()
        expect(result.current.name).toBe('')
        expect(result.current.onSubmit).toBeFunction()
        expect(result.current.phone).toBe('')
        expect(result.current.setEmail).toBeFunction()
        expect(result.current.setName).toBeFunction()
        expect(result.current.setPhone).toBeFunction()
    })
    
    test('onSubmit should call the onSubmit prop.', () => {
        const onSubmit = jest.fn()
        const { result } = renderHook(() => useMyFormComponent({ onSubmit }))
        result.current.onSubmit()
        expect(onSubmit).toHaveBeenCalled()
    })
    
    test('should call toast.error when error is defined.', () => {
        jest.mocked(useGetCountries).mockReturnValue({
            data: null,
            loading: false,
            error: 'An error occurred.',
        })
        const { result } = renderHook(() => useMyFormComponent({ onSubmit: jest.fn() }))
        expect(toast.error).toHaveBeenCalledWith('An error occurred.')
    })
    
    test('should not call toast.error when error is undefined.', () => {
        jest.mocked(useGetCountries).mockReturnValue({
            data: null,
            loading: false,
            error: null,
        })
        const { result } = renderHook(() => useMyFormComponent({ onSubmit: jest.fn() }))
        expect(toast.error).not.toHaveBeenCalled()
    })
    
    test('should call setName when onNameChange is called.', () => {
        const { result } = renderHook(() => useMyFormComponent({ onSubmit: jest.fn() }))
        result.current.onNameChange({ target: { value: 'John' } })
        expect(result.current.name).toBe('John')
    })
    
    test('should call setPhone when onPhoneChange is called.', () => {
        const { result } = renderHook(() => useMyFormComponent({ onSubmit: jest.fn() }))
        result.current.onPhoneChange({ target: { value: '555-5555' } })
        expect(result.current.phone).toBe('555-5555')
    })
    
    test('should call setEmail when onEmailChange is called.', () => {
        const { result } = renderHook(() => useMyFormComponent({ onSubmit: jest.fn() }))
        result.current.onEmailChange({ target: { value: 'test@email.com' } })
        expect(result.current.email).toBe('test@email.com')
    })
})
```

\_\_mocks\_\_/use-my-form-component.js
```jsx
export default function useMyFormComponent({ onSubmit }) {
    return {
        countries: [],
        email: '',
        loading: false,
        name: '',
        onEmailChange: jest.fn(),
        onNameChange: jest.fn(),
        onPhoneChange: jest.fn(),
        onSubmit,
        phone: '',
    }
```

Great now we have the custom hooks tested. We can now test the component.

my-form.test.js
```jsx
import React from 'react'
import { render, screen } from '@testing-library/react'
import MyForm from './my-form'

jest.mock('./hooks/use-my-form-component')

const onSubmit = jest.fn()
test('should render the form.', () => {
    render(<MyForm onSubmit={onSubmit} />)
    expect(screen.getByLabelText('Name')).toBeInTheDocument()
    expect(screen.getByLabelText('Phone')).toBeInTheDocument()
    expect(screen.getByLabelText('Email')).toBeInTheDocument()
    expect(screen.getByLabelText('Country')).toBeInTheDocument()
    expect(screen.getByText('Submit')).toBeInTheDocument()
})

test('should not show Country if loading is true.', () => {
    jest.mocked(useMyFormComponent).mockReturnValue({
        countries: [],
        email: '',
        loading: true,
        name: '',
        onEmailChange: jest.fn(),
        onNameChange: jest.fn(),
        onPhoneChange: jest.fn(),
        onSubmit: jest.fn(),
        phone: '',
    })
    render(<MyForm onSubmit={onSubmit} />)
    expect(screen.queryByLabelText('Country')).not.toBeInTheDocument()
})
```

This is a great start. We now have a component that is easy to test because the business logic is separate.

One quick note here is my opinion differs from the broader React community in one way. I don't believe that you need to directly modify the rendered DOM by modifying fields or clicking buttons. We've already tested that as part of the hook test. If inputs and buttons don't work in React we have much bigger problems. In my opinion, those tests are much better to test in an end-to-end test.

## Conclusion
If you break the pieces of your React components into smaller pieces you will have a much easier time maintaining them and writing tests for them. In addition, these tests are easy to maintain should something need to change and you don't have to build a Rube Goldberg machine of mocks and set them up just so to have test coverage.
