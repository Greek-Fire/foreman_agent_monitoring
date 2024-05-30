import { combineReducers } from 'redux';
import EmptyStateReducer from './Components/EmptyState/EmptyStateReducer';

const reducers = {
  foremanAgentMonitoring: combineReducers({
    emptyState: EmptyStateReducer,
  }),
};

export default reducers;
