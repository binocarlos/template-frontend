import CreateReducer from '../utils/createReducer'
import CreateActions from '../utils/createActions'

const prefix = 'snackbar'

const initialState = {
  open: false,
  text: '',
  type: 'default',
}

const snackbarSetText = (state, text, type) => {
  state.open = true
  state.text = text
  state.type = type
}

const reducers = {
  setMessage: (state, action) => snackbarSetText(state, action.payload, 'default'),
  setSuccess: (state, action) => snackbarSetText(state, action.payload, 'success'),
  setWarning: (state, action) => snackbarSetText(state, action.payload, 'warning'),
  setError: (state, action) => snackbarSetText(state, action.payload, 'error'),
  setInfo: (state, action) => snackbarSetText(state, action.payload, 'info'),
  onClose: (state, action) => {
    state.open = false
  }
}

const reducer = CreateReducer({
  initialState,
  reducers,
  prefix,
})

const actions = CreateActions({
  reducers,
  prefix,
})

export { actions, reducer }
export default actions